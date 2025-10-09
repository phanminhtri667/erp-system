import { Dropdown } from "primereact/dropdown";
import { InputText } from "primereact/inputtext";
import IconButton, {
  EButtonType,
} from "../../components/forms/button/IconButton";
import { useState, useCallback, useRef } from "react";
import { useDropzone } from "react-dropzone";
import {
  ICreateProductPayload,
  productService,
} from "../../services/productServices";
import { Toast } from "primereact/toast";
interface ICategory {
  name: string;
  code: string;
}

const option: ICategory[] = [
  { name: "Áo Thun", code: "AT" },
  { name: "Quần Dài", code: "QD" },
  { name: "Quần Short", code: "QS" },
];

export const ProductForm = () => {
  const [categorySelected, setCategorySelected] = useState<ICategory | null>(
    null
  );
  const [imageBase64, setImageBase64] = useState<Base64URLString | null>(null);

  const toast = useRef<Toast | null>(null);

  // Xử lý drag & drop ảnh
  const onDrop = useCallback((acceptedFiles: File[]) => {
    const file = acceptedFiles[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onload = () => {
      const base64 = reader.result as string;
      setImageBase64(base64);
    };
    reader.readAsDataURL(file);
  }, []);

  const { getRootProps, getInputProps, isDragActive } = useDropzone({
    accept: { "image/*": [] },
    multiple: false,
    onDrop,
  });

  // Xử lý submit form
  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    const formData = new FormData(e.currentTarget);
    const data = Object.fromEntries(formData.entries());
    if (!categorySelected) return;
    const payload: ICreateProductPayload = {
      ...data,
      category: categorySelected.code,
      images: [imageBase64],
      supplier_item_code: "test_supplier_item_code",
    } as ICreateProductPayload;

    const result = await productService.createProduct(payload);
    if (result) {
      toast.current?.show({
        severity: "success",
        summary: "Success",
        detail: "Product created successfully",
        life: 1500,
      });
    }
  };

  return (
    <>
      <form
        onSubmit={handleSubmit}
        className="p-6 bg-white rounded-2xl shadow-md"
      >
        <h2 className="text-2xl font-semibold mb-6 text-gray-800">
          Create Product
        </h2>

        <div className="flex flex-col gap-y-6">
          {/* Hàng 1 */}
          <div className="grid grid-cols-2 gap-6">
            <div className="p-inputgroup flex-1">
              <span className="p-inputgroup-addon">
                <i className="pi pi-th-large"></i>
              </span>
              <InputText name="our_code" placeholder="Product Code" />
            </div>

            <div className="p-inputgroup flex-1">
              <span className="p-inputgroup-addon">
                <i className="pi pi-address-book"></i>
              </span>
              <InputText name="name" placeholder="Product Name" />
            </div>
          </div>

          {/* Hàng 2 */}
          <div className="grid grid-cols-2 gap-6">
            <div className="p-inputgroup flex-1">
              <span className="p-inputgroup-addon">
                <i className="pi pi-dollar"></i>
              </span>
              <InputText name="min_price" placeholder="Selling Price" />
            </div>

            <Dropdown
              name="category"
              value={categorySelected}
              onChange={(e) => setCategorySelected(e.value)}
              options={option}
              optionLabel="name"
              placeholder="Select a Category"
              className="w-full"
            />
          </div>

          {/* Khu vực upload ảnh */}
          <div
            {...getRootProps()}
            className={`border-2 border-dashed rounded-xl p-6 text-center cursor-pointer transition ${
              isDragActive
                ? "border-purple-500 bg-purple-50"
                : "border-gray-300 bg-gray-50 hover:bg-gray-100"
            }`}
          >
            <input {...getInputProps()} />
            {imageBase64 ? (
              <div className="flex flex-col items-center">
                <img
                  src={imageBase64}
                  alt="Preview"
                  className="w-40 h-40 object-cover rounded-lg shadow-md mb-2"
                />
                <p className="text-gray-500 text-sm">Ảnh đã được chọn</p>
              </div>
            ) : (
              <p className="text-gray-500">
                {isDragActive
                  ? "Thả ảnh vào đây..."
                  : "Kéo & thả ảnh vào đây hoặc click để chọn ảnh"}
              </p>
            )}
          </div>
        </div>

        {/* Nút submit */}
        <div className="mt-8 text-right">
          <IconButton label="Create" type={EButtonType.Submit} />
        </div>
      </form>
      <Toast ref={toast} />
    </>
  );
};
