package anyfive.ipims.patent.systemmgt.patteam.team.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class TeamMgtDao extends NAbstractServletDao
{
    public TeamMgtDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 팀정보 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePatTeamTeamList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/patteam/team", "/retrievePatTeamTeamList");
        dao.bind(xReq);

        //팀명
        if (xReq.getParam("DEPT_NAME").equals("") != true) {
            dao.addQuery("deptName");
        }
        //사용구분
        if (xReq.getParam("USE_YN").equals("") != true) {
            dao.addQuery("useYn");
        }
        return dao.executeQueryForGrid(xReq);
    }
    /**
     * 사용구분 변경
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updatePatTeamTeamList(String code ,String useYN) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/patteam/team", "/updatePatTeamTeamList");
        dao.bind("DEPT_CODE", code);
        dao.bind("USE_YN", useYN);


        return dao.executeUpdate();
    }
}
