import React, { useState } from 'react';
import { Dialog } from 'primereact/dialog';
import { InputText } from 'primereact/inputtext';
import { Button } from 'primereact/button';
import { IOrderCreatePayload } from './types/order';

interface OrderCreateDialogProps {
  visible: boolean;
  onHide: () => void;
  onSubmit: (data: IOrderCreatePayload) => void;
}

const OrderCreateDialog: React.FC<OrderCreateDialogProps> = ({ visible, onHide, onSubmit }) => {
  const [formData, setFormData] = useState<IOrderCreatePayload>({
    customer_name: '',
    product_name: '',
    quantity: 1,
  });

  const handleChange = (key: keyof IOrderCreatePayload, value: any) => {
    setFormData((prev) => ({ ...prev, [key]: value }));
  };

  const handleSubmit = () => {
    if (!formData.customer_name || !formData.product_name) return;
    onSubmit(formData);
    onHide();
  };

  return (
    <Dialog
      header="Tạo đơn hàng mới"
      visible={visible}
      style={{ width: '30rem' }}
      modal
      onHide={onHide}
      className="p-fluid"
    >
      <div className="flex flex-col gap-4">
        <div>
          <label className="font-medium mb-1 block">Tên khách hàng</label>
          <InputText
            value={formData.customer_name}
            onChange={(e) => handleChange('customer_name', e.target.value)}
            placeholder="Nhập tên khách hàng"
          />
        </div>

        <div>
          <label className="font-medium mb-1 block">Sản phẩm</label>
          <InputText
            value={formData.product_name}
            onChange={(e) => handleChange('product_name', e.target.value)}
            placeholder="Nhập tên sản phẩm"
          />
        </div>

        <div>
          <label className="font-medium mb-1 block">Số lượng</label>
          <InputText
            type="number"
            value={String(formData.quantity)}
            onChange={(e) => handleChange('quantity', Number(e.target.value))}
            min={1}
          />
        </div>
      </div>

      <div className="flex justify-end gap-2 mt-5">
        <Button label="Hủy" icon="pi pi-times" className="p-button-text" onClick={onHide} />
        <Button label="Tạo đơn" icon="pi pi-check" onClick={handleSubmit} />
      </div>
    </Dialog>
  );
};

export default OrderCreateDialog;
