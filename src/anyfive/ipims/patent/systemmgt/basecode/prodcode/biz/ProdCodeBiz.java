package anyfive.ipims.patent.systemmgt.basecode.prodcode.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.basecode.prodcode.dao.ProdCodeDao;

public class ProdCodeBiz extends NAbstractServletBiz
{
    public ProdCodeBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 제품코드 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveProdCodeList(AjaxRequest xReq) throws NException
    {
        ProdCodeDao dao = new ProdCodeDao(this.nsr);

        return dao.retrieveProdCodeList(xReq);
    }

    /**
     * 제품코드 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createProdCode(AjaxRequest xReq) throws NException
    {
        ProdCodeDao dao = new ProdCodeDao(this.nsr);

        if (dao.retrieveProdCode(xReq).isEmpty() != true) {
            throw new NBizException(this.nsr.message.get("msg.com.error.dup"));
        }

        dao.createProdCode(xReq);
    }

    /**
     * 제품코드 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveProdCode(AjaxRequest xReq) throws NException
    {
        ProdCodeDao dao = new ProdCodeDao(this.nsr);

        NSingleData result = new NSingleData();

        result.set("ds_mainInfo", dao.retrieveProdCode(xReq));

        return result;
    }

    /**
     * 제품코드 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateProdCode(AjaxRequest xReq) throws NException
    {
        ProdCodeDao dao = new ProdCodeDao(this.nsr);

        dao.updateProdCode(xReq);
    }

    /**
     * 기술코드 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteProdCode(AjaxRequest xReq) throws NException
    {
        ProdCodeDao dao = new ProdCodeDao(this.nsr);

        dao.deleteProdCode(xReq);
    }
}
