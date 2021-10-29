import React, { useMemo } from 'react'
import BN from 'bn.js'
import { Box, GU, textStyle, useTheme, useLayout } from '@aragon/ui'
import BalanceToken from './BalanceToken'
import { getConvertedAmount } from '../lib/conversion-utils'
import { useConvertRates } from './useConvertRates'
import BoxHeading from './BoxHeading'




function LiveBalanceContent() {
  const theme = useTheme()
  const { layoutName } = useLayout()
  
  const compact = layoutName === 'small'

  return (
    <div css={`display:flex; 
                flex-direction: column; 
                justify-content: center; 
                align-items:center;
                min-height:100%;
                width: 100%;`}>
        <div css={`display:flex; 
                  flex-direction: column; 
                  justify-content: center; 
                  align-items:center;
                  height:218px;
                  width:218px;
                  border-radius: 115px;
                  background: linear-gradient( 
                    190deg, #32FFF5 -100%, #08BEE5 80% );`}>
          <div css={`display:flex; 
                  flex-direction: column; 
                  justify-content: center; 
                  align-items:center;
                  height:212px;
                  width:212px;
                  border-radius: 115px;
                  background: white;`}>

          {/**Token Supply*/}
          <div css={`color: #637381;
                      font-size: 18px;
                      font-weight: 600;
                      line-height: 1.5;`}>
              ETH: 0.01
          </div>

          {/**USD Conversion (with rate conversion)*/}
          <div css={`color: #888888;
                      font-size: 14px;
                      font-weight: 500;
                      line-height: 1.25;`}>
              $4500
          </div>
        </div>
        </div>
        

    </div>
  )
}


export default LiveBalanceContent
