// MVC + Service Layer
const express = require("express");
const app = express();
const PORT = 3000;

app.listen(PORT);

app.use(express.json());

app.get("/", (req, res) => {
  res.json("Hi");
});

app.get("/product", (req, res) => {
  return res.json({
    bn: [
      {
        title: "BN001",
        // "img": "https://cdn.pixabay.com/photo/2023/03/28/19/55/lake-7884049_640.jpg",
        img:
          "https://cdn.pixabay.com/photo/2023/05/24/05/06/dog-8014047_640.jpg",
        des: "first banner",
      },
      {
        title: "BN002",
        img:
          "https://cdn.pixabay.com/photo/2023/04/02/18/13/electricity-7895181_1280.jpg",
        des: "second banner",
      },
    ],
    list: {
      title: "List1",
      items: [
        {
          title: "BN001",
          // "img": "https://cdn.pixabay.com/photo/2023/03/28/19/55/lake-7884049_640.jpg",
          img:
            "https://images.chosun.com/resizer/HCwK1oBu-WKoTIAtRUi8yxf-IVw=/108x108/smart/s3.amazonaws.com/arc-authors/chosun/927ea7f1-238d-4a38-af3e-7ff40e59c4b6.jpg",
          des: "first banner",
        },
        {
          title: "BN002",
          // "img": "https://cdn.pixabay.com/photo/2023/04/02/18/13/electricity-7895181_1280.jpg",
          img:
            "https://images.chosun.com/resizer/HCwK1oBu-WKoTIAtRUi8yxf-IVw=/108x108/smart/s3.amazonaws.com/arc-authors/chosun/927ea7f1-238d-4a38-af3e-7ff40e59c4b6.jpg",
          des: "second banner",
        },
      ],
    },
    grid: {
      title: "GRID1",
      items: [
        {
          title: "GRID001",
          img:
            "https://cdn.pixabay.com/photo/2023/03/28/19/55/lake-7884049_640.jpg",
        },
        {
          title: "GRID002",
          img:
            "https://cdn.pixabay.com/photo/2023/04/02/18/13/electricity-7895181_1280.jpg",
        },
        {
          title: "GRID003",
          img:
            "https://cdn.pixabay.com/photo/2023/04/02/18/13/electricity-7895181_1280.jpg",
        },
        {
          title: "GRID004",
          img:
            "https://cdn.pixabay.com/photo/2023/04/02/18/13/electricity-7895181_1280.jpg",
        },
      ],
    },
  });
});
