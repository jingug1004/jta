package anyfive.ipims.share.docpaper.docpaper.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.session.SessionUtil;
import anyfive.ipims.share.common.util.SystemTypes;

public class DocPaperDao extends NAbstractServletDao
{
    public DocPaperDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 진행서류 상세목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDocPaperDetailList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/docpaper", "/retrieveDocPaperDetailList");
        dao.bind(xReq);

        if (SessionUtil.getUserInfo(this.nsr).getSystemType().equals(SystemTypes.OFFICE)) {
            dao.addQuery("office", "1");
        } else if (SessionUtil.getUserInfo(this.nsr).isPatentTeam() != true) {
            dao.addQuery("inventor", "1");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 진행서류 정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDocPaperInfo(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/docpaper", "/retrieveDocPaperInfo");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 진행서류 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDocPaper(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/docpaper", "/retrieveDocPaper");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 진행서류 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateDocPaper(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/docpaper", "/updateDocPaper");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 진행서류 확인처리
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int confirmDocPaper(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/docpaper", "/confirmDocPaper");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
