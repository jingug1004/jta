package anyfive.ipims.patent.home.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.session.SessionUtil;

public class BizFlowDao extends NAbstractServletDao
{
    public BizFlowDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 업무현황 건수 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveBizFlowCount(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/home/bizflow", "/retrieveBizFlowCount");
        dao.bind(xReq);

        dao.replaceQuery("baseQuery", "/retrieveBizFlowBase");

        if (SessionUtil.getUserInfo(this.nsr).isJobMan() == true) {
            dao.replaceQuery("commonWhere", "/retrieveBizFlowBase/jobMan");
        } else {
            dao.replaceQuery("commonWhere", "/retrieveBizFlowBase/invUser");
        }

        return dao.executeQuery();
    }

    /**
     * 업무현황 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveBizFlowList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/home/bizflow", "/retrieveBizFlowList");
        dao.bind(xReq);

        dao.replaceQuery("baseQuery", "/retrieveBizFlowBase");

        if (SessionUtil.getUserInfo(this.nsr).isJobMan() == true) {
            dao.replaceQuery("commonWhere", "/retrieveBizFlowBase/jobMan");
        } else {
            dao.replaceQuery("commonWhere", "/retrieveBizFlowBase/invUser");
        }

        return dao.executeQueryForGrid(xReq);
    }
}
