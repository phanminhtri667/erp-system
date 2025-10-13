import React from 'react';
import { Button } from 'primereact/button';
import { Tooltip } from 'primereact/tooltip';
import { EOrderStatus, IOrder } from './types/order';

interface Props {
  order: IOrder;
  onChangeStatus: (id: string, status: EOrderStatus) => void;
}

export default function OrderActionButtons({ order, onChangeStatus }: Props) {
  const { id, status } = order;

  const actions: Partial<Record<EOrderStatus, { next: EOrderStatus; label: string }>> = {
    [EOrderStatus.WAITING_DEPOSIT]: { next: EOrderStatus.DEPOSIT_CONFIRMED, label: 'Xác nhận cọc' },
    [EOrderStatus.DEPOSIT_CONFIRMED]: {
      next: EOrderStatus.SUPPLIER_PROCESSING,
      label: 'Nhà cung cấp xử lý',
    },
    [EOrderStatus.SUPPLIER_PROCESSING]: {
      next: EOrderStatus.SUPPLIER_FINISHED,
      label: 'Nhà cung cấp hoàn tất',
    },
    [EOrderStatus.SUPPLIER_FINISHED]: {
      next: EOrderStatus.WAREHOUSE_RECEIVED,
      label: 'Kho nhận hàng',
    },
    [EOrderStatus.WAREHOUSE_RECEIVED]: { next: EOrderStatus.SHIPPING, label: 'Đang giao' },
    [EOrderStatus.SHIPPING]: { next: EOrderStatus.COMPLETED, label: 'Hoàn tất đơn' },
  };

  const currentAction = actions[status];

  const handleChangeStatus = () => {
    if (currentAction) {
      onChangeStatus(id, currentAction.next);
    }
  };

  return (
    <div className="flex gap-2 items-center">
      <Tooltip target=".btn-update" position="top" content="Cập nhật trạng thái đơn hàng" />

      {currentAction && (
        <Button
          label="Cập nhật"
          icon="pi pi-refresh"
          className="btn-update p-button-sm"
          onClick={handleChangeStatus}
        />
      )}

      <Button
        label="Chi tiết"
        icon="pi pi-search"
        className="p-button-text p-button-sm"
        onClick={() => alert(`Xem chi tiết đơn hàng ${id}`)}
      />
    </div>
  );
}
