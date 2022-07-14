package anyfive.ipims.patent.applymgt.design.extorderletter.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class DesignExtOrderLetterDao extends NAbstractServletDao
{
    public DesignExtOrderLetterDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 디자인해외출원 OL목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtDesignOrderLetterList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/design/extorderletter", "/retrieveDesignExtOrderLetterList");
        dao.bind(xReq);

        // 해외그룹번호검색
        if (xReq.getParam("GRP_NO").equals("") != true) {
            dao.addQuery("grpNo");
        }

        //진행상태
        if (xReq.getParam("STATUS").equals("") != true) {
            dao.addQuery("status");
        }

        // 건담당자
        if (xReq.getParam("JOB_MAN").equals("") != true) {
            dao.addQuery("jobMan");
        }

        // 작성기간
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("dateStart");
        }

        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("dateEnd");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 오더레터 그룹정보 조회
     *
     * @param grpId
     * @return
     * @throws NException
     */
    public NSingleData retrieveDesignExtOrderLetterGroup(String grpId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/design/extorderletter", "/retrieveDesignExtOrderLetterGroup");
        dao.bind("GRP_ID", grpId);

        return dao.executeQueryForSingle();
    }

    /**
     * 디자인해외출원 OL상세조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveDesignExtOrderLetter(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/design/extorderletter", "/retrieveDesignExtOrderLetter");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 디자인해외출원 신규OL생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createDesignExtOrderLetter(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/design/extorderletter", "/createDesignExtOrderLetter");
        dao.bind(xReq);
        dao.executeUpdate();
    }

    /**
     * 디자인해외출원 OL수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateDesignExtOrderLetter(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/design/extorderletter", "/updateDesignExtOrderLetter");
        dao.bind(xReq);

        return dao.executeUpdate();

    }
}
