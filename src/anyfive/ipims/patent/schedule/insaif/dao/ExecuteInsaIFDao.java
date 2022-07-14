package anyfive.ipims.patent.schedule.insaif.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class ExecuteInsaIFDao extends NAbstractServletDao
{
    public ExecuteInsaIFDao(NServiceResource nsr)
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
    public NMultiData retrieveUsrInfo() throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/insa", "/retrieveUsrInfoTIF");

        return dao.executeQuery();
    }
    /**
     * 카운트
     *
     * @return
     * @throws NException
     */
    public NMultiData retrieveAddUser() throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/insa", "/retrieveAddUser");

        return dao.executeQuery();
    }


    /**
     * 인사정보 생성
     *
     * @return
     * @throws NException
     */
    public void createUsrPatentInfo(NSingleData usrInfo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/insa", "/createUsrMasterInfo");
        dao.bind(usrInfo);
        dao.executeUpdate();

        dao.setQuery("/ipims/patent/schedule/insa", "/createUsrPatentInfo");
        dao.bind(usrInfo);
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
     * 특허팀으로 등록된 아이디 조회
     *
     * @return
     * @throws NException
     */
    public NMultiData retrievePatentUserIdInfo1() throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/insa", "/retrievePatentUserIdInfo1");

        return dao.executeQuery();
    }

    /**
     * 특허팀으로 등록된 아이디 중에서 특허팀 권한 여부 조회
     *
     * @return
     * @throws NException
     */
    public int retrievePatentUserIdInfo2Cnt(NSingleData userIdInfo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/insa", "/retrievePatentUserIdInfo2Cnt");
        dao.bind(userIdInfo);

        return dao.executeQueryForSingle().getInt("CNT");
    }



    /**
     * 특허팀 변경시 특허팀에 관한 권한 변경
     *
     * @param insaData
     * @return
     * @throws NException
     */
    public void createPatentUserIdInfo(NSingleData insaData) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/insa", "/createPatentUserIdInfo");
        dao.bind(insaData);
        dao.executeUpdate();
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

    public void createUsrTempInfo(NSingleData insaData) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/insa", "/createUsrTempInfo");
        dao.bind(insaData);
        dao.executeUpdate();
    }

    /**
     * IF 인사 테이블 FLAG = 'S'
     *
     * @param insaData
     * @return
     * @throws NException
     */
    public void updateIFEmpInfo() throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/schedule/insa", "/updateIFEmpInfo");
        dao.executeUpdate();
    }
}
