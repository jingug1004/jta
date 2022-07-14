package anyfive.ipims.patent.applymgt.extpatent.condiv.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.patent.applymgt.extpatent.condiv.dao.ExtPatentConDivDao;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.consts.MappingKind;
import anyfive.ipims.patent.common.mapping.refno.biz.RefNoMappBiz;
import anyfive.ipims.share.common.util.SequenceUtil;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class ExtPatentConDivBiz extends NAbstractServletBiz
{
    public ExtPatentConDivBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 계속/분할OL 모출원 서지사항 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtPatentConDivPrior(AjaxRequest xReq) throws NException
    {
        ExtPatentConDivDao dao = new ExtPatentConDivDao(this.nsr);

        NSingleData result = new NSingleData();

        // 모출원 서지사항 조회
        NSingleData priorInfo = dao.retrieveExtPatentConDivPrior(xReq.getParam("DIVISION_PRIOR_REF_ID"));
        result.set("ds_priorInfo", priorInfo);

        String grpId = priorInfo.getString("GRP_ID");

        // 선출원번호 맵핑목록 조회
        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
        result.set("ds_priorAppList", refBiz.retrieveRefNoList(grpId, MappingKind.GROUP, MappingDiv.NONE));

        return result;
    }

    /**
     * 계속/분할OL 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtPatentConDiv(AjaxRequest xReq) throws NException
    {
        ExtPatentConDivDao dao = new ExtPatentConDivDao(this.nsr);

        NSingleData result = new NSingleData();

        // 계속/분할OL 조회
        NSingleData mainInfo = dao.retrieveExtPatentConDiv(xReq);
        result.set("ds_mainInfo", mainInfo);

        String priorRefId = mainInfo.getString("DIVISION_PRIOR_REF_ID");

        // 모출원 서지사항 조회
        NSingleData priorInfo = dao.retrieveExtPatentConDivPrior(priorRefId);
        result.set("ds_priorInfo", priorInfo);

        String grpId = priorInfo.getString("GRP_ID");

        // 선출원번호 맵핑목록 조회
        RefNoMappBiz refBiz = new RefNoMappBiz(this.nsr);
        result.set("ds_priorAppList", refBiz.retrieveRefNoList(grpId, MappingKind.GROUP, MappingDiv.NONE));

        // 계속/분할 OL정보 조회
        result.set("ds_mainInfo", dao.retrieveExtPatentConDiv(xReq));

        return result;
    }

    /**
     * 계속/분할OL 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createExtPatentConDiv(AjaxRequest xReq) throws NException
    {
        ExtPatentConDivDao dao = new ExtPatentConDivDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // OL_ID 시퀀스 생성
        String olId = seqUtil.getBizId();

        // 데이터 준비
        xReq.setUserData("OL_ID", olId);
        xReq.setUserData("DIVISION_CODE", this.getDivisionCode(xReq, dao));

        // 계속/분할OL 생성
        dao.createExtPatentConDiv(xReq);

        // 계속/분할OL 출원국가 생성
        dao.createExtPatentConDivCountry(xReq);

        // 첨부파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.create(olId, WorkProcessConst.Step.EXT_PATENT_CONDIV_OL);

        return olId;
    }

    /**
     * 계속/분할OL 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateExtPatentConDiv(AjaxRequest xReq) throws NException
    {
        ExtPatentConDivDao dao = new ExtPatentConDivDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // 데이터 준비
        xReq.setUserData("DIVISION_CODE", this.getDivisionCode(xReq, dao));

        // 계속/분할OL 수정
        dao.updateExtPatentConDiv(xReq);

        // 첨부파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));
    }

    /**
     * 분할코드 반환
     *
     * @param xReq
     * @param dao
     * @return
     * @throws NException
     */
    private String getDivisionCode(AjaxRequest xReq, ExtPatentConDivDao dao) throws NException
    {
        String divisionType = xReq.getSingleData("ds_mainInfo").getString("DIVISION_TYPE");

        // 계속/분할OL 분할코드 조회
        String divisionCode = dao.retrieveExtPatentConDivDivisionCode(xReq);

        int divisionLevel;

        if (divisionCode.equals("") == true) {
            divisionLevel = 1;
        } else {
            try {
                divisionLevel = Integer.parseInt(divisionCode.substring(1), 10) + 1;
            } catch (NumberFormatException e) {
                throw new NBizException("분할코드 생성 오류!");
            }
            if (divisionLevel > 9) {
                throw new NBizException("더 이상 분할할 수 없습니다.");
            }
        }

        return (divisionType + Integer.toString(divisionLevel)).substring(0, 2);
    }
}
