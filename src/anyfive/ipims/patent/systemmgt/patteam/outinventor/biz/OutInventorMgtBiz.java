package anyfive.ipims.patent.systemmgt.patteam.outinventor.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.patteam.outinventor.dao.OutInventorMgtDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class OutInventorMgtBiz extends NAbstractServletBiz
{
    public OutInventorMgtBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 외부발명자 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveOutInventorList(AjaxRequest xReq) throws NException
    {
        OutInventorMgtDao dao = new OutInventorMgtDao(this.nsr);

        return dao.retrieveOutInventorList(xReq);
    }

    /**
     * 외부발명자 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveOutInventor(AjaxRequest xReq) throws NException
    {
        OutInventorMgtDao dao = new OutInventorMgtDao(this.nsr);

        return dao.retrieveOutInventor(xReq);
    }

    /**
     * 외부발명자 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createOutInventor(AjaxRequest xReq) throws NException
    {
        OutInventorMgtDao dao = new OutInventorMgtDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String userId = seqUtil.getUserId("X");

        xReq.setUserData("USER_ID", userId);

        if (dao.createUserMaster(xReq) == 0) {
            throw new NBizException("로그인 아이디가 중복되었습니다.");
        }

        dao.createOutInventor(xReq);

        return userId;
    }

    /**
     * 외부발명자 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateOutInventor(AjaxRequest xReq) throws NException
    {
        OutInventorMgtDao dao = new OutInventorMgtDao(this.nsr);

        dao.updateUserMaster(xReq);
        dao.updateOutInventor(xReq);
    }
}
