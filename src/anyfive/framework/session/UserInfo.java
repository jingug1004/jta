package anyfive.framework.session;

import java.util.ArrayList;

import any.core.dataset.NMultiData;
import any.core.session.NAbstractUserInfo;
import anyfive.ipims.share.common.util.SystemTypes;

public class UserInfo extends NAbstractUserInfo
{
    private static final long serialVersionUID = 6759326795925624883L;

    private String            systemType       = null;
    private String            loginId          = null;
    private String            empNo            = null;
    private String            empHname         = null;
    private String            empEname         = null;
    private String            empCname         = null;
    private String            mailAddr         = null;
    private String            divisnCode       = null;
    private String            divisnName       = null;
    private String            deptCode         = null;
    private String            deptName         = null;
    private String            officeCode       = null;
    private String            officeName       = null;
    private ArrayList<String> menuGroupList    = null;

    public String getSystemType()
    {
        return this.systemType;
    }

    public void setSystemType(String systemType)
    {
        this.systemType = systemType;
    }

    public String getLoginId()
    {
        return this.loginId;
    }

    public void setLoginId(String loginId)
    {
        this.loginId = loginId;
    }

    public String getEmpNo()
    {
        return this.empNo;
    }

    public void setEmpNo(String empNo)
    {
        this.empNo = empNo;
    }

    public String getEmpHname()
    {
        return this.empHname;
    }

    public void setEmpHname(String empHname)
    {
        this.empHname = empHname;
    }

    public String getEmpEname()
    {
        return this.empEname;
    }

    public void setEmpEname(String empEname)
    {
        this.empEname = empEname;
    }

    public String getEmpCname()
    {
        return this.empCname;
    }

    public void setEmpCname(String empCname)
    {
        this.empCname = empCname;
    }

    public String getMailAddr()
    {
        return this.mailAddr;
    }

    public void setMailAddr(String mailAddr)
    {
        this.mailAddr = mailAddr;
    }

    public String getDivisnCode()
    {
        return this.divisnCode;
    }

    public void setDivisnCode(String divisnCode)
    {
        this.divisnCode = divisnCode;
    }

    public String getDivisnName()
    {
        return this.divisnName;
    }

    public void setDivisnName(String divisnName)
    {
        this.divisnName = divisnName;
    }

    public String getDeptCode()
    {
        return this.deptCode;
    }

    public void setDeptCode(String deptCode)
    {
        this.deptCode = deptCode;
    }

    public String getDeptName()
    {
        return this.deptName;
    }

    public void setDeptName(String deptName)
    {
        this.deptName = deptName;
    }

    public String getOfficeCode()
    {
        return this.officeCode;
    }

    public void setOfficeCode(String officeCode)
    {
        this.officeCode = officeCode;
    }

    public String getOfficeName()
    {
        return this.officeName;
    }

    public void setOfficeName(String officeName)
    {
        this.officeName = officeName;
    }

    public void setMenuGroupList(NMultiData menuGroupList)
    {
        this.menuGroupList = new ArrayList<String>();

        for (int i = 0; i < menuGroupList.getRowSize(); i++) {
            this.menuGroupList.add(menuGroupList.getString(i, "GROUP_CODE"));
        }
    }

    public boolean isMenuGroupUser(String groupCode1)
    {
        return this.isMenuGroupUser(groupCode1, null, null, null);
    }

    public boolean isMenuGroupUser(String groupCode1, String groupCode2)
    {
        return this.isMenuGroupUser(groupCode1, groupCode2, null, null);
    }

    public boolean isMenuGroupUser(String groupCode1, String groupCode2, String groupCode3)
    {
        return this.isMenuGroupUser(groupCode1, groupCode2, groupCode3, null);
    }

    public boolean isMenuGroupUser(String groupCode1, String groupCode2, String groupCode3, String groupCode4)
    {
        if (this.menuGroupList == null) return false;

        String groupCode = null;

        for (int i = 0; i < this.menuGroupList.size(); i++) {
            groupCode = this.menuGroupList.get(i);
            if (groupCode == null || groupCode.equals("")) continue;
            if (groupCode.equals(groupCode1)) return true;
            if (groupCode.equals(groupCode2)) return true;
            if (groupCode.equals(groupCode3)) return true;
            if (groupCode.equals(groupCode4)) return true;
        }

        return false;
    }

    /**
     * 특허팀 여부 반환
     *
     * @return
     */
    public boolean isPatentTeam()
    {
        if (SystemTypes.PATENT.equals(this.systemType) != true) return false;

        if (this.isJobMan()) return true;
        if (this.isMenuGroupUser("MNG", "SYS", "COS")) return true;

        return false;
    }

    /**
     * 건담당자 여부 반환
     *
     * @return
     */
    public boolean isJobMan()
    {
        if (this.isMenuGroupUser("PAT", "TRA", "DES")) return true;

        return false;
    }
}
