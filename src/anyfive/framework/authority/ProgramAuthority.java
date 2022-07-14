package anyfive.framework.authority;

public class ProgramAuthority
{
    private final String[] authCodes;

    public ProgramAuthority(String[] authCodes)
    {
        this.authCodes = authCodes;
    }

    /**
     * 권한 체크 : 권한이 있는지만 체크
     *
     * @return
     */
    public boolean check()
    {
        return this.authCodes != null && this.authCodes.length > 0;
    }

    /**
     * 권한 체크
     *
     * @param authCode
     *            체크할 권한 코드<br>
     *            콤마로 구분
     * @return
     */
    public boolean check(String authCode)
    {
        if (this.authCodes == null || authCode == null) return false;

        String[] authCodes = authCode.split(",");

        for (int i = 0; i < authCodes.length; i++) {
            for (int j = 0; j < this.authCodes.length; j++) {
                if (this.authCodes[j].equals(authCodes[i].trim())) return true;
            }
        }

        return false;
    }

    /**
     * 권한 체크 : 태그라이브러리용<br>
     *
     * 사용 예<br>
     * <xmp><br>
     * <c:if test="${ipbrain:checkAuthority(PA, 'ALL,C,D')}"><br>
     * </c:if><br>
     * </xmp>
     *
     * @param pa
     *            ProgramAuthority 객체
     * @param authCode
     *            체크할 권한 코드<br>
     *            콤마로 구분
     * @return
     */
    public static boolean check(ProgramAuthority pa, String authCode)
    {
        return pa != null && pa.check(authCode);
    }
}
