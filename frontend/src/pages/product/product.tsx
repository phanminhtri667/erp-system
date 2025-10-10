import { Card } from 'primereact/card';
import { Dialog } from 'primereact/dialog';
import { TabPanel, TabView } from 'primereact/tabview';
import { Toast } from 'primereact/toast';
import { useEffect, useRef, useState } from 'react';
import { productService } from '../../services/productServices';
import './product.scss';
import { ProductForm } from './productCreate';
import ProductTable from './table/productTable';

const Product = () => {
  const [productData, setProductData] = useState<any[]>([]);
  const [filtered, setFiltered] = useState<any[]>([]);
  const [infoDataProduct, setInfoDataProduct] = useState<any>({});
  const [productSelected, setProductSelected] = useState<any>({});
  const [visible, setVisible] = useState(false);
  const toast = useRef<Toast | null>(null);

  useEffect(() => {
    const fetchProducts = async () => {
      const data = await productService.getAll();
      setProductData(data);
      setFiltered(data);
    };
    fetchProducts();
  }, []);

  return (
    <>
      <TabView>
        {/* TAB 1: DANH SÁCH NHÂN VIÊN */}
        <TabPanel header="List Product">
          <div className="product-container">
            {/* --- KHỐI THỐNG KÊ --- */}
            <div className="product-header">
              <Card>
                <div className="card-body pointer">
                  <span className="card-body-name fs-l">Total Product</span>
                  <span className="card-body-content fs-2xl">{infoDataProduct.total || 0}</span>
                </div>
              </Card>
              <Card>
                <div className="card-body pointer">
                  <span className="card-body-name fs-l">Deliverable Product</span>
                  <span className="card-body-content fs-2xl">
                    {infoDataProduct.newProduct || 0}
                  </span>
                </div>
              </Card>
              <Card>
                <div className="card-body pointer">
                  <span className="card-body-name fs-l">Defective Products</span>
                  <span className="card-body-content fs-2xl">{infoDataProduct.male || 0}</span>
                </div>
              </Card>
            </div>

            <div className="product-table">
              <Card>
                <ProductTable data={filtered} onDelete={() => {}} onSelect={() => {}} />
              </Card>
            </div>
          </div>
        </TabPanel>

        <TabPanel header="Add Product">
          <div className="product-form-card">
            <ProductForm />
          </div>
        </TabPanel>
      </TabView>

      <Dialog
        header="Edit Product"
        visible={visible}
        style={{ width: '50vw' }}
        onHide={() => setVisible(false)}
      >
        ProductUpdate
      </Dialog>

      <Toast ref={toast} />
    </>
  );
};

export default Product;
