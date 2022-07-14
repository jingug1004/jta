package anyfive.ipims.patent.systemmgt.basecode.techcode.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.basecode.techcode.dao.TechCodeDao;

public class TechCodeBiz extends NAbstractServletBiz
{
    public TechCodeBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 기술코드관리 트리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTechCodeTree(AjaxRequest xReq) throws NException
    {
        TechCodeDao dao = new TechCodeDao(this.nsr);

        return dao.retrieveTechCodeTree(xReq);
    }

    /**
     * 기술코드관리 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTechCodeList(AjaxRequest xReq) throws NException
    {
        TechCodeDao dao = new TechCodeDao(this.nsr);

        return dao.retrieveTechCodeList(xReq);
    }

    /**
     * 기술코드관리 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createTechCode(AjaxRequest xReq) throws NException
    {
        TechCodeDao dao = new TechCodeDao(this.nsr);

        if (dao.retrieveTechCode(xReq).isEmpty() != true) {
            throw new NBizException(this.nsr.message.get("msg.com.error.dup"));
        }

        dao.createTechCode(xReq);
    }

    /**
     * 기술코드관리 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveTechCode(AjaxRequest xReq) throws NException
    {
        TechCodeDao dao = new TechCodeDao(this.nsr);

        NSingleData result = new NSingleData();

        result.set("ds_mainInfo", dao.retrieveTechCode(xReq));

        return result;
    }

    /**
     * 기술코드관리 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateTechCode(AjaxRequest xReq) throws NException
    {
        TechCodeDao dao = new TechCodeDao(this.nsr);

        dao.updateTechCode(xReq);
    }

    /**
     * 기술코드 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteTechCode(AjaxRequest xReq) throws NException
    {
        TechCodeDao dao = new TechCodeDao(this.nsr);

        if (dao.deleteTechCode(xReq) == 0) {
            throw new NBizException("[삭제 실패]\n\n하위메뉴가 있는 항목은 삭제할 수 없습니다.");
        }

    }
}
