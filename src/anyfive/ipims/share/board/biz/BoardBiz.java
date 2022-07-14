package anyfive.ipims.share.board.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.ipims.share.board.dao.BoardDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class BoardBiz extends NAbstractServletBiz
{
    public BoardBiz(NServiceResource nsr)
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
        BoardDao dao = new BoardDao(this.nsr);

        return dao.retrieveBoardConfig(xReq);
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
        BoardDao dao = new BoardDao(this.nsr);

        return dao.retrieveBoardList(xReq);
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
        BoardDao dao = new BoardDao(this.nsr);

        // 게시판 조회수 증가
        if (xReq.getParam("readCntAdd").equals("1")) {
            dao.updateBoardReadCnt(xReq);
        }

        return dao.retrieveBoard(xReq);
    }

    /**
     * 답변인 경우 원본글 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveBoardForReply(AjaxRequest xReq) throws NException
    {
        BoardDao dao = new BoardDao(this.nsr);

        return dao.retrieveBoard(xReq);
    }

    /**
     * 게시판 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createBoard(AjaxRequest xReq) throws NException
    {
        BoardDao dao = new BoardDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        String brdId = xReq.getParam("BRD_ID");
        String reParent = xReq.getParam("RE_PARENT");
        String orgBrdNo = xReq.getParam("ORG_BRD_NO");

        String brdNo = seqUtil.getBrdNo(brdId);

        xReq.setUserData("BRD_NO", brdNo);

        if (reParent.equals("") && orgBrdNo.equals("")) {
            dao.createBoard(xReq);
        } else {
            if (dao.createBoardReply(xReq) == 0) {
                throw new NBizException("답변글을 작성할 수 없습니다. 원본글이 삭제되었을 수 있습니다.");
            }
            dao.updateBoardReOrderAdd(xReq);
        }

        dao.updateBoardContents(xReq);

        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));

        return brdNo;
    }

    /**
     * 게시판 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateBoard(AjaxRequest xReq) throws NException
    {
        BoardDao dao = new BoardDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        dao.updateBoard(xReq);

        dao.updateBoardContents(xReq);

        fileBiz.updateFileList(xReq.getMultiData("ds_attachFile"));
    }

    /**
     * 게시판 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteBoard(AjaxRequest xReq) throws NException
    {
        BoardDao dao = new BoardDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        NSingleData mainInfo = dao.retrieveBoard(xReq);

        if (dao.deleteBoard(xReq) == 0) {
            dao.updateBoardDelYn(xReq);
        } else {
            this.updateBoardListReOrder(xReq);
        }

        this.deleteBoardListDelYn(xReq);

        fileBiz.deleteFileList(mainInfo.getString("ATTACH_FILE"));
    }

    /**
     * 게시판 삭제(삭제표시건들)
     *
     * @param xReq
     * @return
     * @throws NException
     */
    private void deleteBoardListDelYn(AjaxRequest xReq) throws NException
    {
        BoardDao dao = new BoardDao(this.nsr);

        if (dao.deleteBoardListDelYn(xReq) > 0) {
            this.updateBoardListReOrder(xReq);
            this.deleteBoardListDelYn(xReq);
        }
    }

    /**
     * 게시판 목록 RE_ORDER 조정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    private void updateBoardListReOrder(AjaxRequest xReq) throws NException
    {
        BoardDao dao = new BoardDao(this.nsr);

        NMultiData list = dao.retrieveBoardListForReOrder(xReq);

        for (int i = 0; i < list.getRowSize(); i++) {
            dao.updateBoardListReOrder(xReq.getParam("BRD_ID"), list.getString(i, "BRD_NO"), i + 1);
        }
    }
}
