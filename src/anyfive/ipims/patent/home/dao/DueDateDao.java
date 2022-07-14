package anyfive.ipims.patent.home.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class DueDateDao extends NAbstractServletDao
{
    public DueDateDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * DUE-DATE별 건수 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveDueDateCount(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/home/duedate", "/retrieveDueDateCount");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * DUE-DATE별 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDueDateList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/home/duedate", "/retrieveDueDateList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }
}
