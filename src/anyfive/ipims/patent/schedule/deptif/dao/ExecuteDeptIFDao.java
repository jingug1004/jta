package anyfive.ipims.patent.schedule.deptif.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class ExecuteDeptIFDao extends NAbstractServletDao
{
    public ExecuteDeptIFDao(NServiceResource nsr)
    {
        super(nsr);
    }
    /**
     * 임시테이블 정보 삭제
     *
     * @return
     * @throws NException
     */
    public void deleteDeptInfo() throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/dept", "/deleteDeptInfo");
        dao.executeUpdate();
    }
    /**
     * 부서정보 조회
     *
     * @return
     * @throws NException
     */
    public NMultiData retrieveDeptInfo() throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/dept", "/retrieveDeptInfo");

        return dao.executeQuery();
    }

    /**
     * 부서정보 생성
     *
     * @return
     * @throws NException
     */
    public void createDeptTempInfo(NSingleData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/dept", "/createDeptTempInfo");
        dao.bind(data);
        dao.executeUpdate();
    }

    /**
     * 부서정보 조회
     *
     * @return
     * @throws NException
     */
    public NMultiData retrieveDeptTempInfo() throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/dept", "/retrieveDeptTempInfo");

        return dao.executeQuery();
    }

    /**
     * 부서정보 생성
     *
     * @return
     * @throws NException
     */
    public void createDeptInfo(NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/dept", "/createDeptInfo");
        dao.executeUpdate();
    }

    /**
     * 부서정보 수정
     *
     * @return
     * @throws NException
     */
    public void updateDeptInfo() throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/dept", "/updateDeptInfo");

        dao.executeUpdate();
    }

    /**
     * IF 부서 테이블 상태값 S
     *
     * @return
     * @throws NException
     */
    public void updateIFDeptInfo() throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/dept", "/updateIFDeptInfo");

        dao.executeUpdate();
    }
}
