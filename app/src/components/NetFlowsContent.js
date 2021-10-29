import React, { useMemo } from 'react'
import BN from 'bn.js'
import { Table, TableHeader, TableRow, TableCell, GU, textStyle, useTheme, useLayout } from '@aragon/ui'
import BalanceToken from './BalanceToken'
import { getConvertedAmount } from '../lib/conversion-utils'
import { useConvertRates } from './useConvertRates'
import BoxHeading from './BoxHeading'
import './NetFlowsContent.module.css'





function NetFlowsContent() {
  const theme = useTheme()
  const { layoutName } = useLayout()
  
  const compact = layoutName === 'small'

  const dummyObj = {'supertoken': 'ETHx', 'endDate': new Date(), 'total': 5000, 'transferred':2300, 'rate': -3}

  let dummyData = []
  for(let i=0;i<5;i++){
    dummyData.push(dummyObj)
  }


  return (
    <table >
        <NetFlowsTableHeader/>
        <tbody>
        {dummyData.map((item, idx) => {
            return (
                    <NetFlowsTableRow supertoken={item['supertoken']}
                                        endDate={item['endDate'].toDateString()}
                                        total={item['total']}
                                        transferred={item['transferred']}
                                        rate={item['rate']} />
            )
        })}
        </tbody>

    </table>
  )
}

function NetFlowsTableHeader(){
    return(
        <thead className='header'>
            <th>
                Supertoken
            </th>
            <th>
                End Date
            </th>
            <th>
                Total
            </th>
            <th>
                Transferred
            </th>
            <th>
                Rate ( /s)
            </th>
        </thead>

    )
}

function NetFlowsTableRow({supertoken, endDate, total, transferred, rate}){
    return(
        <tr className='rows'>
            <td>
                {supertoken}
            </td>
            <td>
                {endDate}
            </td>
            <td>
                {total}
            </td>
            <td>
                {transferred}
            </td>
            <td>
                {rate}
            </td>
        </tr>

    )
}

export default NetFlowsContent
