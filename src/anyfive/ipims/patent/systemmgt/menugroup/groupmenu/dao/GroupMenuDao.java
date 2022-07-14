package anyfive.ipims.patent.systemmgt.menugroup.groupmenu.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class GroupMenuDao extends NAbstractServletDao
{
    public GroupMenuDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 그룹별 메뉴 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveGroupMenuList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/menugroup/groupmenu", "/retrieveGroupMenuList");
        dao.bind(xReq);

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 그룹별 메뉴 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] createGroupMenuList(AjaxRequest xReq, NMultiData createList) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/menugroup/groupmenu", "/createGroupMenuList");
        dao.bind(xReq);

        return dao.executeBatch(createList);
    }

    /**
     * 그룹별 메뉴 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] deleteGroupMenuList(AjaxRequest xReq, NMultiData deleteList) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/menugroup/groupmenu", "/deleteGroupMenu");
        dao.bind(xReq);

        return dao.executeBatch(deleteList);
    }
}
