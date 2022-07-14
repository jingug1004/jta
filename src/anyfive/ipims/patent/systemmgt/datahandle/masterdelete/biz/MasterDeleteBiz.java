package anyfive.ipims.patent.systemmgt.datahandle.masterdelete.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.datahandle.masterdelete.dao.MasterDeleteDao;

public class MasterDeleteBiz extends NAbstractServletBiz
{
    public MasterDeleteBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 출원마스터 삭제 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveMasterDeleteList(AjaxRequest xReq) throws NException
    {
        MasterDeleteDao dao = new MasterDeleteDao(this.nsr);

        return dao.retrieveMasterDeleteList(xReq);
    }

    /**
     * 출원마스터 삭제 내역 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveMasterDelete(AjaxRequest xReq) throws NException
    {
        MasterDeleteDao dao = new MasterDeleteDao(this.nsr);

        return dao.retrieveMasterDelete(xReq);
    }

    /**
     * 출원마스터 삭제 처리
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteMaster(AjaxRequest xReq) throws NException
    {
        MasterDeleteDao dao = new MasterDeleteDao(this.nsr);

        dao.deleteMaster(xReq);
    }
}
