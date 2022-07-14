package anyfive.ipims.share.board.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NLobDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class BoardDao extends NAbstractServletDao
{
    public BoardDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 게시판 환경설정 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveBoardConfig(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/board/board", "/retrieveBoardConfig");
        dao.bind(xReq);

        if (xReq.getParam("MENU_CODE").equals("") != true) {
            dao.addQuery("menuCode");
        } else {
            dao.addQuery("brdId");
        }

        return dao.executeQueryForSingle();
    }

    /**
     * 게시판 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveBoardList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/board/board", "/retrieveBoardList");
        dao.bind(xReq);

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            if (xReq.getParam("SEARCH_KIND").equals("SUBJECT") == true) {
                dao.addQuery("subject");
            } else if (xReq.getParam("SEARCH_KIND").equals("CRE_USER_NAME") == true) {
                dao.addQuery("creUserName");
            }
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 게시판 조회수 증가
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateBoardReadCnt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/board/board", "/updateBoardReadCnt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 게시판 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveBoard(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/board/board", "/retrieveBoard");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 게시판 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createBoard(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/board/board", "/createBoard");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 게시판 생성(답변글)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createBoardReply(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/board/board", "/createBoardReply");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 게시판 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateBoard(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/board/board", "/updateBoard");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 게시판 수정(삭제표시)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateBoardDelYn(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/board/board", "/updateBoardDelYn");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 게시판 내용 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateBoardContents(AjaxRequest xReq) throws NException
    {
        NLobDao dao = new NLobDao(this.nsr);

        dao.setQuery("/ipims/share/board/board", "/updateBoardContents");
        dao.bind(xReq);
        dao.setClobData("CONTENTS", xReq.getSingleData("ds_mainInfo").getString("CONTENTS"));

        return dao.executeUpdate();
    }

    /**
     * 게시판 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteBoard(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/board/board", "/deleteBoard");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 게시판 목록 삭제(삭제표시건들)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteBoardListDelYn(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/board/board", "/deleteBoardListDelYn");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * RE_ORDER 증가
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateBoardReOrderAdd(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/board/board", "/updateBoardReOrderAdd");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * RE_ORDER 조정을 위한 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveBoardListForReOrder(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/board/board", "/retrieveBoardListForReOrder");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * RE_ORDER 조정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateBoardListReOrder(String brdId, String brdNo, int reOrder) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/board/board", "/updateBoardListReOrder");
        dao.bind("RE_ORDER", Integer.toString(reOrder));
        dao.bind("BRD_ID", brdId);
        dao.bind("BRD_NO", brdNo);

        return dao.executeUpdate();
    }
}
