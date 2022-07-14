package anyfive.ipims.patent.applymgt.priorjob.oalist.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class OAListDao extends NAbstractServletDao
{
    public OAListDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * OA검토현황 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveOAList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorjob/oalist", "/retrieveOAList");
        dao.bind(xReq);

        // OA서류
        if (xReq.getParam("OA_PAPER_CODE").equals("") != true) {
            dao.addQuery("oaPaperCode");
        }

        // 건담당자
        if (xReq.getParam("JOB_MAN").equals("") != true) {
            dao.addQuery("jobMan");
        }

        // 종료여부
        if (xReq.getParam("END_YN").equals("") != true) {
            dao.addQuery("endYn");
        }

        return dao.executeQueryForGrid(xReq);
    }
}
