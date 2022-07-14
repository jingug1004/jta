package anyfive.ipims.patent.systemmgt.basecode.pjtcode.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.basecode.pjtcode.dao.PjtCodeDao;

public class PjtCodeBiz extends NAbstractServletBiz
{
    public PjtCodeBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 프로젝트코드 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePjtCodeList(AjaxRequest xReq) throws NException
    {
        PjtCodeDao dao = new PjtCodeDao(this.nsr);

        return dao.retrievePjtCodeList(xReq);
    }

    /**
     * 프로젝트코드 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createPjtCode(AjaxRequest xReq) throws NException
    {
        PjtCodeDao dao = new PjtCodeDao(this.nsr);

        if (dao.retrievePjtCode(xReq).isEmpty() != true) {
            throw new NBizException(this.nsr.message.get("msg.com.error.dup"));
        }

        dao.createPjtCode(xReq);
    }

    /**
     * 프로젝트코드 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePjtCode(AjaxRequest xReq) throws NException
    {
        PjtCodeDao dao = new PjtCodeDao(this.nsr);

        NSingleData result = new NSingleData();

        result.set("ds_mainInfo", dao.retrievePjtCode(xReq));

        return result;
    }

    /**
     * 프로젝트코드 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updatePjtCode(AjaxRequest xReq) throws NException
    {
        PjtCodeDao dao = new PjtCodeDao(this.nsr);

        dao.updatePjtCode(xReq);
    }

    /**
     * 프로젝트코드 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deletePjtCode(AjaxRequest xReq) throws NException
    {
        PjtCodeDao dao = new PjtCodeDao(this.nsr);

        dao.deletePjtCode(xReq);
    }
}
