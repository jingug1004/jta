package anyfive.ipims.patent.systemmgt.boardmgt.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class BoardMgtDao extends NAbstractServletDao
{
    public BoardMgtDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 게시판 관리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveBoardMgtList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/boardmgt/boardmgt", "/retrieveBoardMgtList");
        dao.bind(xReq);

        // 메뉴구분
        if (xReq.getParam("SYSTEM_TYPE").equals("") != true) {
            dao.addQuery("systemType");
        }

        // 게시판 ID
        if (xReq.getParam("BRD_ID").equals("") != true) {
            dao.addQuery("brdId");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 게시판 관리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveBoardMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/boardmgt/boardmgt", "/retrieveBoardMgt");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 게시판 관리 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createBoardMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/boardmgt/boardmgt", "/createBoardMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 게시판 관리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateBoardMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/boardmgt/boardmgt", "/updateBoardMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 게시판 관리 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteBoardMgt(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/boardmgt/boardmgt", "/deleteBoardMgt");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
