package anyfive.ipims.patent.systemmgt.officemgt.user.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.officemgt.user.dao.OfficeMgtUserDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class OfficeMgtUserBiz extends NAbstractServletBiz
{
    public OfficeMgtUserBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 사무소 사용자 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveOfficeMgtUserList(AjaxRequest xReq) throws NException
    {
        OfficeMgtUserDao dao = new OfficeMgtUserDao(this.nsr);

        return dao.retrieveOfficeMgtUserList(xReq);
    }

    /**
     * 사무소 사용자 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveOfficeMgtUser(AjaxRequest xReq) throws NException
    {
        OfficeMgtUserDao dao = new OfficeMgtUserDao(this.nsr);

        return dao.retrieveOfficeMgtUser(xReq);
    }

    /**
     * 사무소 사용자 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String createOfficeMgtUser(AjaxRequest xReq) throws NException
    {
        OfficeMgtUserDao dao = new OfficeMgtUserDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        String userId = seqUtil.getUserId("F");

        xReq.setUserData("USER_ID", userId);

        if (dao.createUserMst(xReq) == 0) {
            throw new NBizException("로그인 아이디가 중복되었습니다.");
        }

        dao.createOfficeMgtUser(xReq);

        return userId;
    }

    /**
     * 사무소 사용자 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateOfficeMgtUser(AjaxRequest xReq) throws NException
    {
        OfficeMgtUserDao dao = new OfficeMgtUserDao(this.nsr);

        dao.updateUserMst(xReq);
        dao.updateOfficeMgtUser(xReq);
    }

    /**
     * 사무소 사용자 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteOfficeMgtUser(AjaxRequest xReq) throws NException
    {
        OfficeMgtUserDao dao = new OfficeMgtUserDao(this.nsr);

        dao.deleteOfficeMgtUser(xReq);
        dao.deleteUserMst(xReq);
    }

    /**
     * 비밀번호 오류횟수 초기화
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateUserMstPwErrCnt(AjaxRequest xReq) throws NException
    {
        OfficeMgtUserDao dao = new OfficeMgtUserDao(this.nsr);

        dao.updateUserMstPwErrCnt(xReq);
    }
}
