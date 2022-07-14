package anyfive.ipims.patent.systemmgt.datahandle.jobmanchange.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class JobManChangeDao extends NAbstractServletDao
{
    public JobManChangeDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 건담당자 일괄변경 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveJobManChangeList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/datahandle/jobmanchange", "/retrieveJobManChangeList");
        dao.bind(xReq);

        // 국내외구분
        if (xReq.getParam("INOUT_DIV").equals("") != true) {
            dao.addQuery("inoutDiv");
        }

        // 권리구분
        if (xReq.getParam("RIGHT_DIV").equals("") != true) {
            dao.addQuery("rightDiv");
        }

        // 건담당자
        if (xReq.getParam("JOB_MAN").equals("") != true) {
            dao.addQuery("jobMan");
        }

        // 검색번호
        if (xReq.getParam("NUMBER_GUBUN").equals("") != true && xReq.getParam("NUMBER_TEXT").equals("") != true) {
            dao.addQuery("numberText");
        }

        // 검색일자
        if (xReq.getParam("DATE_GUBUN").equals("") != true) {
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
     * 출원마스터의 건담당자 변경(비고란에 History 추가)
     *
     * @param refId
     * @param jobMan
     * @return
     * @throws NException
     */
    public int updateApplyMaster(String refId, String jobMan) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/datahandle/jobmanchange", "/updateApplyMaster");
        dao.bind("REF_ID", refId);
        dao.bind("JOB_MAN", jobMan);

        return dao.executeUpdate();
    }

    /**
     * 해외그룹의 건담당자 변경(비고란에 History 추가)
     *
     * @param refId
     * @param jobMan
     * @return
     * @throws NException
     */
    public int updateExtGroup(String refId, String jobMan) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/datahandle/jobmanchange", "/updateExtGroup");
        dao.bind("REF_ID", refId);
        dao.bind("JOB_MAN", jobMan);

        return dao.executeUpdate();
    }

    /**
     * 진행서류 비고내용 조회
     *
     * @param refId
     * @param jobMan
     * @return
     * @throws NException
     */
    public String retrievePaperRemark(String refId, String jobMan) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/datahandle/jobmanchange", "/retrievePaperRemark");
        dao.bind("REF_ID", refId);
        dao.bind("JOB_MAN", jobMan);

        return dao.executeQueryForString();
    }
    /**
     * 건담당자 일괄변경 메일 수신자 정보 조회
     *
     * @param jobMan
     * @return NSingleData
     * @throws NException
     */
    public NSingleData getRecvInfo(String jobMan ) throws NException{
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/datahandle/jobmanchange", "/getRecvInfo");
        dao.bind("JOB_MAN", jobMan);

        return dao.executeQueryForSingle();
    };

}
