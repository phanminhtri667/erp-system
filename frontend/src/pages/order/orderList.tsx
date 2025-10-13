import React from 'react';
import { DataTable } from 'primereact/datatable';
import { Column } from 'primereact/column';
import { IOrder } from './types/order';
import OrderStatusBadge from './OrderStatusBadge';
import OrderActionButtons from './orderActionButtons';

interface Props {
  orders: IOrder[];
  onChangeStatus: (id: string, status: any) => void;
}

const OrderList: React.FC<Props> = ({ orders, onChangeStatus }) => {
  const renderStatus = (rowData: IOrder) => <OrderStatusBadge status={rowData.status} />;

  const renderActions = (rowData: IOrder) => (
    <OrderActionButtons order={rowData} onChangeStatus={onChangeStatus} />
  );

  return (
    <div className=" rounded-xl shadow p-4">
      <DataTable
        value={orders}
        paginator
        rows={10}
        emptyMessage="Chưa có đơn hàng nào."
        responsiveLayout="scroll"
        className="text-sm"
      >
        <Column field="id" header="Mã đơn" />
        <Column field="customer_name" header="Khách hàng" />
        <Column field="product_name" header="Sản phẩm" />
        <Column field="quantity" header="Số lượng" />
        <Column field="status" header="Trạng thái" body={renderStatus} />
        <Column header="Hành động" body={renderActions} />
      </DataTable>
    </div>
  );
};

export default OrderList;
