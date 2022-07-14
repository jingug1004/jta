package anyfive.ipims.patent.systemmgt.boardmgt.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.boardmgt.dao.BoardMgtDao;

public class BoardMgtBiz extends NAbstractServletBiz
{
    public BoardMgtBiz(NServiceResource nsr)
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
        BoardMgtDao dao = new BoardMgtDao(this.nsr);

        return dao.retrieveBoardMgtList(xReq);
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
        BoardMgtDao dao = new BoardMgtDao(this.nsr);

        return dao.retrieveBoardMgt(xReq);
    }

    /**
     * 게시판 관리 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createBoardMgt(AjaxRequest xReq) throws NException
    {
        BoardMgtDao dao = new BoardMgtDao(this.nsr);

        if (dao.createBoardMgt(xReq) == 0) {
            throw new NBizException("게시판 관리를 생성할 수 없습니다.\n\n이미 추가된 메뉴인지 확인하시기 바랍니다.");
        }
    }

    /**
     * 게시판 관리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateBoardMgt(AjaxRequest xReq) throws NException
    {
        BoardMgtDao dao = new BoardMgtDao(this.nsr);

        dao.updateBoardMgt(xReq);
    }

    /**
     * 게시판 관리 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteBoardMgt(AjaxRequest xReq) throws NException
    {
        BoardMgtDao dao = new BoardMgtDao(this.nsr);

        dao.deleteBoardMgt(xReq);
    }
}
