package anyfive.ipims.patent.common.mapping.project.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.patent.common.mapping.project.dao.ProjectMappDao;

public class ProjectMappBiz extends NAbstractServletBiz
{
    public ProjectMappBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 프로젝트 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveProjectList(String refId, String mappDiv) throws NException
    {
        ProjectMappDao dao = new ProjectMappDao(this.nsr);

        return dao.retrieveProjectList(refId, mappDiv);
    }

    /**
     * 프로젝트 목록 저장
     *
     * @param refId
     * @param data
     * @throws NException
     */
    public void updateProjectList(String refId, String mappDiv, NMultiData data) throws NException
    {
        ProjectMappDao dao = new ProjectMappDao(this.nsr);

        dao.deleteProjectList(refId, mappDiv, data);
        dao.createProjectList(refId, mappDiv, data);
    }

    /**
     * 프로젝트 목록 전체 삭제
     *
     * @param refId
     * @throws NException
     */
    public void deleteProjectListAll(String refId, String mappDiv) throws NException
    {
        ProjectMappDao dao = new ProjectMappDao(this.nsr);

        dao.deleteProjectListAll(refId, mappDiv);
    }
}
