package anyfive.ipims.patent.applymgt.priorjob.todolist.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class ToDoListDao extends NAbstractServletDao
{
    public ToDoListDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * TO-DO List 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveToDoList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorjob/todolist", "/retrieveToDoList");
        dao.bind(xReq);

        // 권리구분
        if (xReq.getParam("RIGHT_DIV").equals("") != true) {
            dao.addQuery("rightDiv");
        }

        // 국내외구분
        if (xReq.getParam("INOUT_DIV").equals("") != true) {
            dao.addQuery("inoutDiv");
        }

        // 건담당자
        if (xReq.getParam("JOB_MAN").equals("") != true) {
            dao.addQuery("jobMan");
        }

        return dao.executeQueryForGrid(xReq);
    }
}
