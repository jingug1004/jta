package anyfive.ipims.patent.applymgt.tmark.extorderletter.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class TMarkExtOrderLetterDao extends NAbstractServletDao
{
    public TMarkExtOrderLetterDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 상표해외출원 OL목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtTMarkOrderLetterList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/extorderletter", "/retrieveTMarkExtOrderLetterList");
        dao.bind(xReq);

        // 해외그룹번호검색
        if (xReq.getParam("GRP_NO").equals("") != true) {
            dao.addQuery("grpNo");
        }

        // 상표명
        if (xReq.getParam("SR_TMARK_NAME").equals("") != true) {
            dao.addQuery("srTmarkName");
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
     * 상표 오더레터 그룹정보 조회
     *
     * @param grpId
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkExtOrderLetterGroup(String grpId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/extorderletter", "/retrieveTMarkExtOrderLetterGroup");
        dao.bind("GRP_ID", grpId);

        return dao.executeQueryForSingle();
    }

    /**
     * 상표해외출원 OL상세조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTMarkExtOrderLetter(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/extorderletter", "/retrieveTMarkExtOrderLetter");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 상표해외출원 신규OL생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createTMarkExtOrderLetter(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/extorderletter", "/createTMarkExtOrderLetter");
        dao.bind(xReq);
        dao.executeUpdate();
    }

    /**
     * 상표해외출원 OL수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateTMarkExtOrderLetter(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/tmark/extorderletter", "/updateTMarkExtOrderLetter");
        dao.bind(xReq);

        return dao.executeUpdate();

    }
}
