package anyfive.ipims.share.board.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.share.board.biz.BoardBiz;

/**
 * 게시판 삭제
 */
public class DeleteBoard implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        BoardBiz biz = new BoardBiz(nsr);
        biz.deleteBoard(xReq);
        nsr.closeConnection();
    }
}
