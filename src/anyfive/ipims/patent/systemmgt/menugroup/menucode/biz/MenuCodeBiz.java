package anyfive.ipims.patent.systemmgt.menugroup.menucode.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.menugroup.menucode.dao.MenuCodeDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class MenuCodeBiz extends NAbstractServletBiz
{
    public MenuCodeBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 메뉴관리 트리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveMenuCodeTree(AjaxRequest xReq) throws NException
    {
        MenuCodeDao dao = new MenuCodeDao(this.nsr);

        return dao.retrieveMenuCodeTree(xReq);
    }

    /**
     * 메뉴관리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveMenuCodeList(AjaxRequest xReq) throws NException
    {
        MenuCodeDao dao = new MenuCodeDao(this.nsr);

        return dao.retrieveMenuCodeList(xReq);
    }

    /**
     * 메뉴관리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveMenuCode(AjaxRequest xReq) throws NException
    {
        MenuCodeDao dao = new MenuCodeDao(this.nsr);

        NSingleData result = new NSingleData();

        result.set("ds_mainInfo", dao.retrieveMenuCode(xReq));
        result.set("ds_menuNameList", dao.retrieveMenuNameList(xReq));

        return result;
    }

    /**
     * 메뉴관리 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createMenuCode(AjaxRequest xReq) throws NException
    {
        MenuCodeDao dao = new MenuCodeDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        xReq.setUserData("MENU_CODE", seqUtil.getMenuCode(xReq.getParam("SYSTEM_TYPE")));

        dao.createMenuCode(xReq);
        dao.createMenuNameList(xReq);
    }

    /**
     * 메뉴관리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateMenuCode(AjaxRequest xReq) throws NException
    {
        MenuCodeDao dao = new MenuCodeDao(this.nsr);

        dao.updateMenuCode(xReq);
        dao.deleteMenuNameList(xReq);
        dao.createMenuNameList(xReq);
    }

    /**
     * 메뉴관리 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteMenuCode(AjaxRequest xReq) throws NException
    {
        MenuCodeDao dao = new MenuCodeDao(this.nsr);

        dao.deleteGroupMenuList(xReq);
        dao.deleteMenuNameList(xReq);

        if (dao.deleteMenuCode(xReq) == 0) {
            throw new NBizException("[삭제 실패]\n\n하위메뉴가 있는 항목은 삭제할 수 없습니다.");
        }
    }

    /**
     * 메뉴순서 변경
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateMenuOrdList(AjaxRequest xReq) throws NException
    {
        MenuCodeDao dao = new MenuCodeDao(this.nsr);

        dao.updateMenuOrdList(xReq);
    }
}
