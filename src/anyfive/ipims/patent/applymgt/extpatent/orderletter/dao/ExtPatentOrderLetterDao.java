package anyfive.ipims.patent.applymgt.extpatent.orderletter.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class ExtPatentOrderLetterDao extends NAbstractServletDao
{
    public ExtPatentOrderLetterDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 오더레터 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtPatentOrderLetterList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/orderletter", "/retrieveExtPatentOrderLetterList");
        dao.bind(xReq);

        // 번호검색
        if (xReq.getParam("GRP_NO").equals("") != true) {
            dao.addQuery("grpNo");
        }

        if(xReq.getParam("SR_NO_ONLY").equals("1") != true){

            // 발명의명칭
            if (xReq.getParam("KO_APP_TITLE").equals("") != true) {
                dao.addQuery("koAppTitle");
            }

            // 진행상태
            if (xReq.getParam("OL_STATUS").equals("") != true) {
                dao.addQuery("olStatus");
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
    public NSingleData retrieveExtPatentOrderLetterGroup(String grpId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/orderletter", "/retrieveExtPatentOrderLetterGroup");
        dao.bind("GRP_ID", grpId);

        return dao.executeQueryForSingle();
    }

    /**
     * 오더레터 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtPatentOrderLetter(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/orderletter", "/retrieveExtPatentOrderLetter");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 오더레터 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createExtPatentOrderLetter(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/orderletter", "/createExtPatentOrderLetter");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 오더레터 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateExtPatentOrderLetter(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/orderletter", "/updateExtPatentOrderLetter");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
