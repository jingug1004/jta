package anyfive.ipims.patent.systemmgt.datahandle.appreqdelete.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NProcedureDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class AppReqDeleteDao extends NAbstractServletDao
{
    public AppReqDeleteDao(NServiceResource nsr)
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/datahandle/appreqdelete", "/retrieveAppReqDeleteList");
        dao.bind(xReq);
        dao.bind("BIZ_ACT", WorkProcessConst.Action.MODIFY);

        // 권리구분
        if (xReq.getParam("RIGHT_DIV").equals("") != true) {
            dao.addQuery("rightDiv");
        }

        // REF-NO
        if (xReq.getParam("REF_NO").equals("") != true) {
            dao.addQuery("refNo");
        }

        // 작성일자
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("dateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("dateEnd");
        }

        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/datahandle/appreqdelete", "/retrieveAppReqDelete");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 출원의뢰서 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteAppReq(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/datahandle/appreqdelete", "/deleteIntPatentRequestPat");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/systemmgt/datahandle/appreqdelete", "/deleteIntPatentRequestDesign");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/systemmgt/datahandle/appreqdelete", "/deleteIntPatentRequestTMark");
        dao.bind(xReq);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/systemmgt/datahandle/appreqdelete", "/deleteIntPatentRequest");
        dao.bind(xReq);
        dao.bind("BIZ_ACT", WorkProcessConst.Action.MODIFY);
        return dao.executeUpdate();
    }

    /**
     * 출원마스터 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteMaster(AjaxRequest xReq) throws NException
    {
        NProcedureDao dao = new NProcedureDao(this.nsr);

        dao.setProcedure("/ipims/patent/systemmgt/datahandle/appreqdelete", "/deleteMaster");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
