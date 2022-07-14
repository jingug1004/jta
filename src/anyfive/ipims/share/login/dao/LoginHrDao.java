package anyfive.ipims.share.login.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class LoginHrDao extends NAbstractServletDao
{
    public LoginHrDao(NServiceResource nsr)
    {
        super(nsr);
    }
    /**
     * 임시테이블 정보 삭제
     *
     * @return
     * @throws NException
     */
    public void deleteUserInfo() throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/insa", "/deleteUserInfo");
        dao.executeUpdate();
    }
    /**
     * 인사정보 조회
     *
     * @return
     * @throws NException
     */
    public NMultiData retrieveUsrInfo(String loginId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/insa", "/retrieveUsrInfo");
        dao.bind("EMP_ID", loginId);

        return dao.executeQuery();
    }
    /**
     * 카운트
     *
     * @return
     * @throws NException
     */
    public int retrieveAddUserCnt() throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/insa", "/retrieveAddUserCnt");

        return dao.executeQueryForSingle().getInt("CNT");
    }

    /**
     * 인사정보 생성
     *
     * @return
     * @throws NException
     */
    public void createUsrPatentInfo() throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/insa", "/createUsrMasterInfo");
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/schedule/insa", "/createUsrPatentInfo");
        dao.executeUpdate();
    }

    /**
     * 인사정보 생성
     *
     * @param insaData
     * @return
     * @throws NException
     */
    public void createUsrPatentInfo2(NSingleData insaData) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/insa", "/createUsrMasterInfo");
        dao.bind(insaData);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/schedule/insa", "/createUsrPatentInfo");
        dao.bind(insaData);
        dao.executeUpdate();
    }

    /**
     * 인사정보 조회
     *
     * @return
     * @throws NException
     */
    public NMultiData retrieveUsrPatentInfo() throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/insa", "/retrieveUsrPatentInfo");

        return dao.executeQuery();
    }

    /**
     * 인사정보(MASTER) 수정
     *
     * @throws NException
     */
    public void updateUsrMasterInfo() throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/insa", "/updateUsrMasterInfo");
        dao.executeUpdate();
    }

    /**
     * 인사정보(PATENT) 수정
     *
     * @return
     * @throws NException
     */
    public void updateUsrPatentInfo() throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/insa", "/updateUsrPatentInfo");

        dao.executeUpdate();
    }

    /**
     * 인사정보(MASTER) 수정
     *
     * @param insaData
     * @return
     * @throws NException
     */
    public int updateUsrMasterInfo2(NSingleData insaData) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/insa", "/updateUsrMasterInfo");
        dao.bind(insaData);

        return dao.executeUpdate();
    }

    /**
     * 인사정보(PATENT) 수정
     *
     * @param insaData
     * @return
     * @throws NException
     */
    public int updateUsrPatentInfo2(NSingleData insaData) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/insa", "/updateUsrPatentInfo");
        dao.bind(insaData);

        return dao.executeUpdate();
    }

    public void createUsrTempInfo(NSingleData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/insa", "/createUsrTempInfo");
        dao.bind(data);
        dao.executeUpdate();
    }
}
