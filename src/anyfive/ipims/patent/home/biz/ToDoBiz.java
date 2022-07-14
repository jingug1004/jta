package anyfive.ipims.patent.home.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.home.dao.ToDoDao;

public class ToDoBiz extends NAbstractServletBiz
{
    public ToDoBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * To Do 건수 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveToDoCount(AjaxRequest xReq) throws NException
    {
        ToDoDao dao = new ToDoDao(this.nsr);

        return dao.retrieveToDoCount(xReq);
    }

    /**
     * To Do 평가 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveToDoEvalList(AjaxRequest xReq) throws NException
    {
        ToDoDao dao = new ToDoDao(this.nsr);

        return dao.retrieveToDoEvalList(xReq);
    }

    /**
     * To Do 신규접수 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveToDoNewList(AjaxRequest xReq) throws NException
    {
        ToDoDao dao = new ToDoDao(this.nsr);

        return dao.retrieveToDoNewList(xReq);
    }

    /**
     * To Do 진행서류 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveToDoPaperList(AjaxRequest xReq) throws NException
    {
        ToDoDao dao = new ToDoDao(this.nsr);

        return dao.retrieveToDoPaperList(xReq);
    }
}
