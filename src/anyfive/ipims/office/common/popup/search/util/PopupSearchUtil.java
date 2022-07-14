package anyfive.ipims.office.common.popup.search.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NDataProtocol;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.framework.grid.util.GridResponse;

public class PopupSearchUtil extends NAbstractServletDao
{
    public PopupSearchUtil(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 검색결과 공통 처리
     *
     * @param xReq
     * @param dao
     * @return
     * @throws NException
     */
    public static NDataProtocol getResult(AjaxRequest xReq, NQueryDao dao) throws NException
    {
        if (xReq.getParam("_DS_ID_").equals("")) {
            return dao.executeQueryForGrid(xReq);
        }

        return dao.executeQuery();
    }

    /**
     * 검색결과 공통 처리
     *
     * @param req
     * @param res
     * @param xReq
     * @param data
     * @throws Exception
     */
    public static void flush(HttpServletRequest req, HttpServletResponse res, AjaxRequest xReq, NDataProtocol data) throws Exception
    {
        if (xReq.getParam("_DS_ID_").equals("")) {
            GridResponse xRes = new GridResponse(req, res);
            xRes.flush((NSingleData)data);
        } else {
            AjaxResponse xRes = new AjaxResponse(res);
            xRes.flush(data, xReq.getParam("_DS_ID_"));
        }
    }
}
