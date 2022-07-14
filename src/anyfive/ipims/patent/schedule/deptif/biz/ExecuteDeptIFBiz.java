package anyfive.ipims.patent.schedule.deptif.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.patent.schedule.deptif.dao.ExecuteDeptIFDao;

public class ExecuteDeptIFBiz extends NAbstractServletBiz
{
    public ExecuteDeptIFBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * View 부서정보 I/F Process
     *
     * @return
     * @throws NException
     */
    public void updateDeptInfo() throws NException
    {
        ExecuteDeptIFDao dao = new ExecuteDeptIFDao(this.nsr);

        //임시 부서테이블 정보 삭제
        dao.deleteDeptInfo();

        NMultiData deptData =  dao.retrieveDeptInfo();

        // TEMP 부서 테이블에 저장
        for (int i=0; i<deptData.getRowSize(); i++){
            //view 정보 입력
            NSingleData insertData = deptData.getSingleData(i);
            dao.createDeptTempInfo(insertData);
        }

        // 부서 테이블에 저장
        dao.updateDeptInfo();

        // 부서IF 상태값 변경 I -> S
        dao.updateIFDeptInfo();

    }
}
