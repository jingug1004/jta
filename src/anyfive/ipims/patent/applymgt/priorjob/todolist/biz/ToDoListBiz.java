package anyfive.ipims.patent.applymgt.priorjob.todolist.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.applymgt.priorjob.todolist.dao.ToDoListDao;

public class ToDoListBiz extends NAbstractServletBiz
{
    public ToDoListBiz(NServiceResource nsr)
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
        ToDoListDao dao = new ToDoListDao(this.nsr);

        return dao.retrieveToDoList(xReq);
    }
}
