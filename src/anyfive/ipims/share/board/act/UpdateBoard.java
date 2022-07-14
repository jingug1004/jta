package anyfive.ipims.share.board.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.share.board.biz.BoardBiz;

/**
 * 게시판 수정
 */
public class UpdateBoard implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        BoardBiz biz = new BoardBiz(nsr);
        biz.updateBoard(xReq);
        nsr.closeConnection();
    }
}
