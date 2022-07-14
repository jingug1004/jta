package anyfive.ipims.patent.ipbiz.contract.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.patent.ipbiz.contract.dao.ContractDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class ContractBiz extends NAbstractServletBiz
{
    public ContractBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 계약서 현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveContractList(AjaxRequest xReq) throws NException
    {
        ContractDao dao = new ContractDao(this.nsr);

        return dao.retrieveContractList(xReq);
    }

    /**
     * 계약서 작성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createContractC(AjaxRequest xReq) throws NException
    {
        ContractDao dao = new ContractDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        NSingleData mainInfo = xReq.getSingleData("ds_mainInfo");

        // MGT_ID 시퀀스 생성
        String mgtId = seqUtil.getBizId();

        xReq.setUserData("MGT_ID", mgtId);
        xReq.setUserData("MGT_NO", seqUtil.getContractNo(mainInfo.getString("CONTRACT_KIND")));

        // 계약서 작성
        dao.createContractC(xReq);

        // 첨부파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));

        return mgtId;
    }

    /**
     * 계약서 상세 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveContractRD(AjaxRequest xReq) throws NException
    {
        ContractDao dao = new ContractDao(this.nsr);

        NSingleData result = new NSingleData();

        // 계약서 상세 조회
        result.set("ds_mainInfo", dao.retrieveContractRD(xReq));

        return result;
    }

    /**
     * 계약서 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String updateContractU(AjaxRequest xReq) throws NException
    {
        ContractDao dao = new ContractDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String mgtId = xReq.getParam("MGT_ID");

         // 심의요청서 작성
        dao.updateContractU(xReq);

        // 첨부파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));

        return mgtId;
    }

    /**
     * 계약서  삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteContract(AjaxRequest xReq) throws NException
    {
        ContractDao dao = new ContractDao(this.nsr);

        if (dao.deleteContract(xReq) == 0) {
            throw new NBizException("계약서를 삭제할 수 없습니다.");
        }
    }
}
