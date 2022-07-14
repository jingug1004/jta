package anyfive.ipims.patent.common.approvaladdon.util;

import any.core.dataset.NSingleData;
import any.core.exception.NException;

public interface ApprovalAbstractBiz
{
    public abstract void execute(String apprNo, NSingleData apprKey, short apprEvent, NSingleData apprMgt) throws NException;
}
