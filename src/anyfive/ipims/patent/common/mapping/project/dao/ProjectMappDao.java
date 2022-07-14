package anyfive.ipims.patent.common.mapping.project.dao;

import any.core.dataset.NJobTypeEnum;
import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class ProjectMappDao extends NAbstractServletDao
{
    public ProjectMappDao(NServiceResource nsr)
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/project", "/retrieveProjectList");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeQuery();
    }

    /**
     * 프로젝트 목록 생성
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int[] createProjectList(String refId, String mappDiv, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/project", "/createProject");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeBatch(data, NJobTypeEnum.CREATE);
    }

    /**
     * 프로젝트 목록 삭제
     *
     * @param refId
     * @param data
     * @return
     * @throws NException
     */
    public int[] deleteProjectList(String refId, String mappDiv, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/project", "/deleteProject");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeBatch(data, NJobTypeEnum.DELETE);
    }

    /**
     * 프로젝트 목록 전체 삭제
     *
     * @param refId
     * @return
     * @throws NException
     */
    public int deleteProjectListAll(String refId, String mappDiv) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/project", "/deleteProjectListAll");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeUpdate();
    }
}
