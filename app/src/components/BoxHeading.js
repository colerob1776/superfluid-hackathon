import React, { useMemo } from 'react'
import BN from 'bn.js'
import { Box, GU, textStyle, useTheme, useLayout } from '@aragon/ui'
import BalanceToken from './BalanceToken'
import { getConvertedAmount } from '../lib/conversion-utils'
import { useConvertRates } from './useConvertRates'



function BoxHeading({ primary, secondary }) {
  const theme = useTheme()
  const { layoutName } = useLayout()
  

  return (
    <div css={`display: flex;justify-content:space-between; width: 100% `}>
        <div css={``}>
            {primary}
        </div>
        <div css={``}>
            {secondary}
        </div>
    </div>
  )
}

export default BoxHeading
