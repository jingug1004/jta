package anyfive.ipims.patent.systemmgt.datahandle.appreqdelete.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.datahandle.appreqdelete.dao.AppReqDeleteDao;

public class AppReqDeleteBiz extends NAbstractServletBiz
{
    public AppReqDeleteBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 출원의뢰서 삭제 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAppReqDeleteList(AjaxRequest xReq) throws NException
    {
        AppReqDeleteDao dao = new AppReqDeleteDao(this.nsr);

        return dao.retrieveAppReqDeleteList(xReq);
    }

    /**
     * 출원의뢰서 삭제 내역 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAppReqDelete(AjaxRequest xReq) throws NException
    {
        AppReqDeleteDao dao = new AppReqDeleteDao(this.nsr);

        return dao.retrieveAppReqDelete(xReq);
    }

    /**
     * 출원의뢰서 삭제 처리
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteAppReq(AjaxRequest xReq) throws NException
    {
        AppReqDeleteDao dao = new AppReqDeleteDao(this.nsr);

        if (dao.deleteAppReq(xReq) == 0) {
            throw new NBizException("삭제할 수 없는 건입니다.");
        }

        dao.deleteMaster(xReq);
    }
}
