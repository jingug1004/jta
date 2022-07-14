package anyfive.ipims.patent.applymgt.extpatent.group.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class ExtPatentGroupDao extends NAbstractServletDao
{
    public ExtPatentGroupDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 해외출원품의 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtPatentGroupList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/group", "/retrieveExtPatentGroupList");
        dao.bind(xReq);

        // 번호검색
        if (xReq.getParam("NO_GUBUN").equals("") != true && xReq.getParam("SR_NO").equals("") != true) {
            if (xReq.getParam("NO_GUBUN").equals("GRP_NO")) {
                dao.addQuery("grpNo");
            }
            if(xReq.getParam("NO_GUBUN").equals("REF_NO")) {
                dao.addQuery("RefNo");
            }
            if(xReq.getParam("NO_GUBUN").equals("PAT_NO")) {
                dao.addQuery("PatNo");
            }
        }

        if(xReq.getParam("SR_NO_ONLY").equals("1") != true){

            // 발명의명칭
            if (xReq.getParam("KO_APP_TITLE").equals("") != true) {
                dao.addQuery("koAppTitle");
            }

            // 작성기간
            if (xReq.getParam("DATE_START").equals("") != true) {
                dao.addQuery("dateStart");
            }

            if (xReq.getParam("DATE_END").equals("") != true) {
                dao.addQuery("dateEnd");
            }

            // 건담당자
            if (xReq.getParam("JOB_MAN").equals("") != true) {
                dao.addQuery("jobMan");
            }
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 국내마스터 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveIntMaster(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/group", "/retrieveIntMaster");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 해외출원품의 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtPatentGroup(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/group", "/retrieveExtPatentGroup");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 해외출원품의 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createExtPatentGroup(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/group", "/createExtPatentGroup");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 해외출원품의 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateExtPatentGroup(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/group", "/updateExtPatentGroup");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 해외출원품의 출원인수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateAppMan(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/group", "/updateAppMan");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
