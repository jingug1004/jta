package anyfive.ipims.patent.systemmgt.datahandle.masterdelete.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NProcedureDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class MasterDeleteDao extends NAbstractServletDao
{
    public MasterDeleteDao(NServiceResource nsr)
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/datahandle/masterdelete", "/retrieveMasterDeleteList");
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

        // 발명의 명칭
        if (xReq.getParam("APP_TITLE").equals("") != true) {
            dao.addQuery("appTitle");
        }

        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/datahandle/masterdelete", "/retrieveMasterDelete");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
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

        dao.setProcedure("/ipims/patent/systemmgt/datahandle/masterdelete", "/deleteMaster");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
