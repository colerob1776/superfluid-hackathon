import React, { useState } from 'react'
import BN from 'bn.js'
import { DropDown, GU, textStyle, useTheme, useLayout } from '@aragon/ui'
import BalanceToken from './BalanceToken'
import { getConvertedAmount } from '../lib/conversion-utils'
import { useConvertRates } from './useConvertRates'
import BoxHeading from './BoxHeading'


function TokenDropdown() {
  const theme = useTheme()
  const [selected, setSelected] = useState(1)

  return (
    <DropDown
    items={['Total', 'ETH']}
    selected={selected}
    onChange={setSelected}
    />
  )
}

export default TokenDropdown
