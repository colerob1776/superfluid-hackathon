import React, { useMemo } from 'react'
import BN from 'bn.js'
import { Box, GU, textStyle, useTheme, useLayout } from '@aragon/ui'
import BalanceToken from './BalanceToken'
import { getConvertedAmount } from '../lib/conversion-utils'
import { useConvertRates } from './useConvertRates'
import BoxHeading from './BoxHeading'
import TokenDropdown from './TokenDropdown'
import LiveBalanceContent from './LiveBalanceContent'

// Prepare the balances for the BalanceToken component
function useBalanceItems(balances) {
  const verifiedSymbols = balances
    .filter(({ verified }) => verified)
    .map(({ symbol }) => symbol)

  const convertRates = useConvertRates(verifiedSymbols)

  const balanceItems = useMemo(() => {
    return balances.map(
      ({ address, amount, decimals, symbol, verified }) => {
        return {
          address,
          amount,
          convertedAmount: convertRates[symbol]
            ? getConvertedAmount(amount, convertRates[symbol], decimals)
            : new BN('-1'),
          decimals,
          symbol,
          verified,
        }
      },
      [balances, convertRates]
    )
  })
  return balanceItems
}

function LiveBalance({ balances, contentHeight }) {
  const theme = useTheme()
  const { layoutName } = useLayout()
  const balanceItems = useBalanceItems(balances)
  
  const compact = layoutName === 'small'

  return (
    <Box heading={<BoxHeading primary='Live Balances' secondary={<TokenDropdown />} />} padding={0}>
      <div
        css={`
          padding: ${(compact ? 1 : 2) * GU}px;
          height: ${contentHeight}px;
        `}
      >
          <LiveBalanceContent />
      </div>
    </Box>
  )
}

export default LiveBalance
