package anyfive.ipims.office.common.mapping.project.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.office.common.mapping.project.dao.ProjectMappDao;

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
}
