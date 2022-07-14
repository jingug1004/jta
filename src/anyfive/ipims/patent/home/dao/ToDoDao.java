package anyfive.ipims.patent.home.dao;

import java.util.ArrayList;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.session.SessionUtil;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class ToDoDao extends NAbstractServletDao
{
    public ToDoDao(NServiceResource nsr)
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
        NQueryDao dao = new NQueryDao(this.nsr);

        ArrayList<String> queryList = new ArrayList<String>();

        queryList.add("APPR");
        queryList.add("EVAL");
        queryList.add("NEW");
        queryList.add("PAPER");

        dao.setQuery("/ipims/patent/home/todo", "/retrieveToDoCount");
        dao.bind(xReq);
        dao.bind("BIZ_ACT", WorkProcessConst.Action.JOB_MAN_ASSIGN);

        for (int i = 0; i < queryList.size(); i++) {
            if (i > 0)dao.addQuery("union");
            dao.replaceText("ID", queryList.get(i));
            dao.replaceQuery("LIST_QUERY", "/retrieveToDoList_" + queryList.get(i));
        }

        if (SessionUtil.getUserInfo(this.nsr).isPatentTeam() == true) {
            dao.addQuery("/retrieveToDoList_PAPER/jobMan");
        } else {
            dao.addQuery("/retrieveToDoList_PAPER/inventor");
        }

        return dao.executeQuery();
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/home/todo", "/retrieveToDoList_EVAL");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/home/todo", "/retrieveToDoList_NEW");
        dao.bind(xReq);
        dao.bind("BIZ_ACT", WorkProcessConst.Action.JOB_MAN_ASSIGN);

        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/home/todo", "/retrieveToDoList_PAPER");
        dao.bind(xReq);

        if (SessionUtil.getUserInfo(this.nsr).isPatentTeam() == true) {
            dao.addQuery("/retrieveToDoList_PAPER/jobMan");
        } else {
            dao.addQuery("/retrieveToDoList_PAPER/inventor");
        }

        return dao.executeQueryForGrid(xReq);
    }
}
