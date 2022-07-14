package anyfive.ipims.patent.common.approval.util;

import java.lang.reflect.Field;

public class ApprovalEvents
{
    /**
     * 결재없음
     */
    public static final short NONE     = 1;

    /**
     * 결재요청
     */
    public static final short REQUEST  = 2;

    /**
     * 결재취소
     */
    public static final short CANCEL   = 3;

    /**
     * 승인
     */
    public static final short AGREE    = 4;

    /**
     * 반려
     */
    public static final short REJECT   = 5;

    /**
     * 상위요청
     */
    public static final short UPPER    = 6;

    /**
     * 최종승인
     */
    public static final short AGREEALL = 7;

    /**
     * 재작성
     */
    public static final short REWRITE  = 8;

    public static final short valueOf(String name)
    {
        try {
            return ApprovalEvents.class.getDeclaredField(name).getShort(ApprovalEvents.class);
        } catch (NoSuchFieldException e) {
        } catch (IllegalAccessException e) {
        }

        return -1;
    }

    public static final String name(short value)
    {
        Field[] fields = ApprovalEvents.class.getDeclaredFields();

        try {
            for (int i = 0; i < fields.length; i++) {
                if (fields[i].getShort(ApprovalEvents.class) == value) return fields[i].getName();
            }
        } catch (IllegalAccessException e) {
        }

        return null;
    }
}
