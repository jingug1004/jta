package anyfive.ipims.patent.schedule.insaif.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.patent.schedule.insaif.dao.ExecuteInsaIFDao;

public class ExecuteInsaIFBiz extends NAbstractServletBiz
{
    public ExecuteInsaIFBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 인사정보 I/F Process
     *
     * @return
     * @throws NException
     */
    public void updateUsrMasterInfo() throws NException
    {
        ExecuteInsaIFDao dao = new ExecuteInsaIFDao(this.nsr);

        NMultiData usrInfoList = dao.retrieveAddUser();

        for(int i=0;i<usrInfoList.getRowSize();i++) {
            NSingleData usrInfo = usrInfoList.getSingleData(i);
            dao.createUsrPatentInfo(usrInfo);
        }

        dao.updateUsrMasterInfo();

    }

    /**
     * 인사정보 I/F Process
     *
     * @return
     * @throws NException
     */
    public void updateUsrPatentInfo() throws NException
    {
        ExecuteInsaIFDao dao = new ExecuteInsaIFDao(this.nsr);

        dao.updateUsrPatentInfo();

        NMultiData patentUserIdInfo = dao.retrievePatentUserIdInfo1();

        for (int i = 0; i < patentUserIdInfo.getRowSize(); i++) {
            NSingleData userIdInfo = patentUserIdInfo.getSingleData(i);
            userIdInfo.setString("SYSTEM_TYPE","PATENT");
            userIdInfo.setString("GROUP_CODE","PAT");

            if (dao.retrievePatentUserIdInfo2Cnt(userIdInfo) == 0) {
                dao.createPatentUserIdInfo(userIdInfo);
            }

        }

    }

    /**
     * 인사정보 I/F Process
     *
     * @return
     * @throws NException
     */
    public void updateUsrPatentInfo2() throws NException
    {
        ExecuteInsaIFDao dao = new ExecuteInsaIFDao(this.nsr);

        NMultiData usrPatentList = dao.retrieveUsrPatentInfo();

        for (int i = 0; i < usrPatentList.getRowSize(); i++) {
            NSingleData insaInfo = usrPatentList.getSingleData(i);

            if (dao.updateUsrMasterInfo2(insaInfo) == 0) {
                dao.createUsrPatentInfo2(insaInfo);
            } else {
                dao.updateUsrPatentInfo2(insaInfo);
            }
        }
    }
    /**
     * View 정보 확인
     *
     * @return
     * @throws NException
     */

    public void retrieveUsrInfo() throws NException
    {
        ExecuteInsaIFDao dao = new ExecuteInsaIFDao(this.nsr);

        //임시 테이블 정보 삭제
        dao.deleteUserInfo();

        NMultiData usrInfoList =  dao.retrieveUsrInfo();
        System.out.println("VIEWDATE==>"+usrInfoList.toString());

        for(int i=0; i<usrInfoList.getRowSize();i++) {
            NSingleData usrInfo = usrInfoList.getSingleData(i);
            dao.createUsrTempInfo(usrInfo);
        }

        //IF 테이블 FLAG = 'S'
        dao.updateIFEmpInfo();

    }
}
